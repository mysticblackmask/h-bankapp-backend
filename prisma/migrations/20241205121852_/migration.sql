/*
  Warnings:

  - You are about to drop the `deposit` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `transfer_receive` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `transfer_send` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `users` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `withdraw` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE "deposit";

-- DropTable
DROP TABLE "transfer_receive";

-- DropTable
DROP TABLE "transfer_send";

-- DropTable
DROP TABLE "users";

-- DropTable
DROP TABLE "withdraw";

-- CreateTable
CREATE TABLE "Deposit" (
    "id" SERIAL NOT NULL,
    "user" TEXT NOT NULL,
    "amount" TEXT NOT NULL,
    "balance" TEXT NOT NULL,
    "date" TEXT NOT NULL,

    CONSTRAINT "Deposit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TransferSend" (
    "id" SERIAL NOT NULL,
    "sendId" TEXT NOT NULL,
    "receiveId" TEXT NOT NULL,
    "amount" TEXT NOT NULL,
    "balance" TEXT NOT NULL,
    "date" TEXT NOT NULL,

    CONSTRAINT "TransferSend_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TransferReceive" (
    "id" SERIAL NOT NULL,
    "receiveId" TEXT NOT NULL,
    "sendId" TEXT NOT NULL,
    "amount" TEXT NOT NULL,
    "balance" TEXT NOT NULL,
    "date" TEXT NOT NULL,

    CONSTRAINT "TransferReceive_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Users" (
    "id" SERIAL NOT NULL,
    "userId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "date" TEXT NOT NULL,
    "balance" TEXT NOT NULL,

    CONSTRAINT "Users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Withdraw" (
    "id" SERIAL NOT NULL,
    "user" TEXT NOT NULL,
    "amount" TEXT NOT NULL,
    "date" TEXT NOT NULL,
    "balance" TEXT NOT NULL DEFAULT '0.00',

    CONSTRAINT "Withdraw_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Users_userId_key" ON "Users"("userId");
