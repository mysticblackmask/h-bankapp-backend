import { Request, Response } from "express";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

const getSum = (data: { amount: string }[]) =>
  data.reduce(
    (total, { amount }) =>
      total + Math.abs(parseFloat(amount.replace(/,/g, ""))),
    0
  );

export const dashes = async (req: Request, res: Response) => {
  const { id } = req.params;
  const total = (await prisma.users.findUnique({ where: { userId: id } })) ?? {
    balance: 0,
  };
  const totalData = total.balance;

  const [send, receive, deposit, withdraw] = await Promise.all([
    prisma.transferSend.findMany({ where: { sendId: id } }),
    prisma.transferReceive.findMany({ where: { receiveId: id } }),
    prisma.deposit.findMany({ where: { user: id } }),
    prisma.withdraw.findMany({ where: { user: id } }),
  ]);

  const sendData = getSum(send);
  const receiveData = getSum(receive);
  const depositData = getSum(deposit);
  const withdrawData = getSum(withdraw);

  const come = {
    send: (sendData + withdrawData).toLocaleString(),
    receive: (receiveData + depositData).toLocaleString(),
  };

  const combinedHistory = await prisma.$queryRaw`
    SELECT amount, balance, date, "user" AS id, 'deposits' AS type FROM "Deposit" WHERE "user" = ${id}
    UNION ALL
    SELECT amount, balance, date, "user" AS id, 'withdraws' AS type FROM "Withdraw" WHERE "user" = ${id}
    UNION ALL
    SELECT amount, balance, date, "receiveId" AS id, 'send' AS type FROM "TransferSend" WHERE "sendId" = ${id}
    UNION ALL
    SELECT amount, balance, date, "sendId" AS id, 'receive' AS type FROM "TransferReceive" WHERE "receiveId" = ${id}
    ORDER BY date DESC
    LIMIT 7;
  `;

  res.status(200).json({ data: combinedHistory, rela: come, total: totalData });
};
