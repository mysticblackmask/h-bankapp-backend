-- AlterTable
ALTER TABLE "article" ADD COLUMN     "dfdfg" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "sadf" MONEY NOT NULL DEFAULT '$0.00'::money;

-- AlterTable
ALTER TABLE "withdraw" ALTER COLUMN "balance" SET DEFAULT '0.00';
