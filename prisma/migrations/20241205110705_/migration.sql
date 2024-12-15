-- CreateTable
CREATE TABLE "transfer_send" (
    "id" SERIAL NOT NULL,
    "sendId" TEXT NOT NULL,
    "receiveId" TEXT NOT NULL,
    "amount" TEXT NOT NULL,
    "balance" TEXT NOT NULL,
    "date" TEXT NOT NULL,

    CONSTRAINT "transfer_send_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "transfer_receive" (
    "id" SERIAL NOT NULL,
    "receiveId" TEXT NOT NULL,
    "sendId" TEXT NOT NULL,
    "amount" TEXT NOT NULL,
    "balance" TEXT NOT NULL,
    "date" TEXT NOT NULL,

    CONSTRAINT "transfer_receive_pkey" PRIMARY KEY ("id")
);
