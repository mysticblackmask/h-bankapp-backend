/*
  Warnings:

  - A unique constraint covering the columns `[user,cardId]` on the table `deposit` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "deposit_user_cardId_key" ON "deposit"("user", "cardId");
