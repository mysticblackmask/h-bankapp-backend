/*
  Warnings:

  - You are about to drop the column `cardId` on the `deposit` table. All the data in the column will be lost.
  - You are about to drop the column `country` on the `transfer` table. All the data in the column will be lost.
  - You are about to drop the column `cardId` on the `withdraw` table. All the data in the column will be lost.
  - Added the required column `amount` to the `deposit` table without a default value. This is not possible if the table is not empty.
  - Added the required column `balance` to the `deposit` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "deposit" DROP COLUMN "cardId",
ADD COLUMN     "amount" TEXT NOT NULL,
ADD COLUMN     "balance" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "transfer" DROP COLUMN "country";

-- AlterTable
ALTER TABLE "withdraw" DROP COLUMN "cardId";
