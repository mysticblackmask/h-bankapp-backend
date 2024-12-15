/*
  Warnings:

  - Made the column `user` on table `deposit` required. This step will fail if there are existing NULL values in that column.
  - Made the column `date` on table `deposit` required. This step will fail if there are existing NULL values in that column.
  - Made the column `cardId` on table `deposit` required. This step will fail if there are existing NULL values in that column.
  - Made the column `user` on table `transfer` required. This step will fail if there are existing NULL values in that column.
  - Made the column `amount` on table `transfer` required. This step will fail if there are existing NULL values in that column.
  - Made the column `date` on table `transfer` required. This step will fail if there are existing NULL values in that column.
  - Made the column `country` on table `transfer` required. This step will fail if there are existing NULL values in that column.
  - Made the column `balance` on table `transfer` required. This step will fail if there are existing NULL values in that column.
  - Made the column `cardId` on table `transfer` required. This step will fail if there are existing NULL values in that column.
  - Made the column `name` on table `users` required. This step will fail if there are existing NULL values in that column.
  - Made the column `date` on table `users` required. This step will fail if there are existing NULL values in that column.
  - Made the column `balance` on table `users` required. This step will fail if there are existing NULL values in that column.
  - Made the column `user` on table `withdraw` required. This step will fail if there are existing NULL values in that column.
  - Made the column `amount` on table `withdraw` required. This step will fail if there are existing NULL values in that column.
  - Made the column `date` on table `withdraw` required. This step will fail if there are existing NULL values in that column.
  - Made the column `balance` on table `withdraw` required. This step will fail if there are existing NULL values in that column.
  - Made the column `cardId` on table `withdraw` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "deposit" ALTER COLUMN "user" SET NOT NULL,
ALTER COLUMN "date" SET NOT NULL,
ALTER COLUMN "cardId" SET NOT NULL;

-- AlterTable
ALTER TABLE "transfer" ALTER COLUMN "user" SET NOT NULL,
ALTER COLUMN "amount" SET NOT NULL,
ALTER COLUMN "date" SET NOT NULL,
ALTER COLUMN "country" SET NOT NULL,
ALTER COLUMN "balance" SET NOT NULL,
ALTER COLUMN "cardId" SET NOT NULL;

-- AlterTable
ALTER TABLE "users" ALTER COLUMN "name" SET NOT NULL,
ALTER COLUMN "date" SET NOT NULL,
ALTER COLUMN "balance" SET NOT NULL;

-- AlterTable
ALTER TABLE "withdraw" ALTER COLUMN "user" SET NOT NULL,
ALTER COLUMN "amount" SET NOT NULL,
ALTER COLUMN "date" SET NOT NULL,
ALTER COLUMN "balance" SET NOT NULL,
ALTER COLUMN "cardId" SET NOT NULL;
