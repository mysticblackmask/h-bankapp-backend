import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export const validateAccountExists = async (cardId: string) => {
  const account = await prisma.users.findUnique({ where: { userId: cardId } });
  if (!account) {
    return "Account not found";
  }
  return account;
};
