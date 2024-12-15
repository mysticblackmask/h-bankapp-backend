-- AddForeignKey
ALTER TABLE "Deposit" ADD CONSTRAINT "Deposit_user_fkey" FOREIGN KEY ("user") REFERENCES "Users"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TransferSend" ADD CONSTRAINT "TransferSend_sendId_fkey" FOREIGN KEY ("sendId") REFERENCES "Users"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TransferReceive" ADD CONSTRAINT "TransferReceive_sendId_fkey" FOREIGN KEY ("sendId") REFERENCES "Users"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Withdraw" ADD CONSTRAINT "Withdraw_user_fkey" FOREIGN KEY ("user") REFERENCES "Users"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;
