import { Request, Response } from "express";
import { PrismaClient } from "@prisma/client";
import { validateAccountExists } from "../validations/cards.validation";
import {
  validateAmount,
  validateSufficientBalance,
} from "../validations/amount.validation";

const prisma = new PrismaClient();

export const deposit = async (req: Request, res: Response) => {
  const { id } = req.params;

  const { amount } = req.body;

  const account = await validateAccountExists(id);

  const amountError = validateAmount(amount);

  if (amountError) return res.status(400).json({ msg: amountError });

  if (typeof account !== "string") {
    const newBalance = (
      parseFloat(account.balance.replace(/,/g, "")) +
      parseFloat(amount.toFixed(2))
    ).toLocaleString();
    await prisma.deposit.create({
      data: {
        user: id,
        amount: `${amount.toLocaleString()}`,
        balance: newBalance,
        date: new Date().toLocaleString(),
      },
    });
    await prisma.users.update({
      where: { userId: id },
      data: { date: new Date().toLocaleString(), balance: newBalance },
    });
    return res.status(200).json({ msg: "Deposit yourID" });
  } else return res.status(400).json({ msg: "Account not found" });
};

export const withdraw = async (req: Request, res: Response) => {
  const { id } = req.params;
  const { amount } = req.body;

  const amountError = validateAmount(amount);

  if (amountError) return res.status(400).json({ msg: amountError });

  const account = await validateAccountExists(id);
  if (typeof account !== "string") {
    const balance = parseFloat(account.balance.replace(/,/g, ""));

    const balanceError = validateSufficientBalance(balance, amount);

    if (balanceError) return res.status(400).json({ msg: balanceError });

    const newBalance = (balance - amount).toLocaleString();

    const updatedAccount = await prisma.withdraw.create({
      data: {
        user: id,
        amount: amount.toLocaleString(),
        date: new Date().toLocaleString(),
        balance: newBalance,
      },
    });

    await prisma.users.update({
      where: { userId: id },
      data: { balance: newBalance, date: new Date().toLocaleString() },
    });

    return res.status(200).json(updatedAccount);
  } else {
    return res.status(400).json({ msg: "Account not found" });
  }
};

export const transfer = async (req: Request, res: Response) => {
  const { id } = req.params;

  const { amount, cardId } = req.body;

  if (id === cardId)
    return res.status(400).json({ msg: "ID to send is yours" });

  const amountError = validateAmount(amount);

  if (amountError) return res.status(400).json({ msg: amountError });

  const sendAccount = await validateAccountExists(id);

  if (typeof sendAccount !== "string") {
    const receiveAccount = await validateAccountExists(cardId);

    if (typeof receiveAccount === "string")
      return res.status(400).json("Not Found ID to send");

    const sendBalance = parseFloat(sendAccount.balance.replace(/,/g, ""));

    const receiveBalance = parseFloat(receiveAccount.balance.replace(/,/g, ""));

    const balanceError = validateSufficientBalance(sendBalance, amount);

    if (balanceError) return res.status(400).json({ msg: balanceError });

    const newSendBalance = (sendBalance - amount).toLocaleString();

    const newReceiveBalance = (receiveBalance + amount).toLocaleString();

    const updatedSendAccount = await prisma.transferSend.create({
      data: {
        sendId: id,
        receiveId: cardId,
        amount: amount.toLocaleString(),
        date: new Date().toLocaleString(),
        balance: newSendBalance,
      },
    });

    await prisma.transferReceive.create({
      data: {
        sendId: id,
        receiveId: cardId,
        amount: amount.toLocaleString(),
        date: new Date().toLocaleString(),
        balance: newReceiveBalance,
      },
    });

    await prisma.users.update({
      where: { userId: cardId },
      data: { balance: newReceiveBalance, date: new Date().toLocaleString() },
    });

    await prisma.users.update({
      where: { userId: id },
      data: { balance: newSendBalance, date: new Date().toLocaleString() },
    });

    return res.status(200).json(updatedSendAccount);
  } else {
    return res.status(400).json({ msg: "Account not found" });
  }
};

export const totalAmount = async (req: Request, res: Response) => {
  const { id } = req.params;

  const card = await prisma.users.findUnique({
    where: { userId: id },
  });

  if (!card) return res.status(400).json("Not found ID");

  const amount = parseFloat(card.balance.replace(/,/g, ""));

  return res.status(200).json(amount);
};

export const history = async (req: Request, res: Response) => {
  const { id } = req.params;
  const { page } = req.body;
  const limit = 5;
  const offset = (page - 1) * limit;
  const combinedHistory = await prisma.$queryRaw`
    SELECT amount, balance, date, "user" AS id, 'deposits' AS type FROM "Deposit" WHERE "user" = ${id}
    UNION ALL
    SELECT amount, balance, date, "user" AS id, 'withdraws' AS type FROM "Withdraw" WHERE "user" = ${id}
    UNION ALL
    SELECT amount, balance, date, "receiveId" AS id, 'send' AS type FROM "TransferSend" WHERE "sendId" = ${id}
    UNION ALL
    SELECT amount, balance, date, "sendId" AS id, 'receive' AS type FROM "TransferReceive" WHERE "receiveId" = ${id}
    ORDER BY date DESC
    LIMIT ${limit} OFFSET ${offset};
  `;

  const totalCount = await prisma.$queryRaw<number[]>`
   SELECT 1 FROM "Deposit" WHERE "user" = ${id}
    UNION ALL
    SELECT 1 FROM "Withdraw" WHERE "user" = ${id}
    UNION ALL
    SELECT 1 FROM "TransferSend" WHERE "sendId" = ${id}
    UNION ALL
    SELECT 1 FROM "TransferReceive" WHERE "receiveId" = ${id}
  `;
  const total = Math.round((totalCount.length || 0) / limit);

  return res.status(200).json({ data: combinedHistory, total: total });
};
