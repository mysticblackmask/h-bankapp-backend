-- CreateTable
CREATE TABLE "article" (
    "id" SERIAL NOT NULL,
    "title" TEXT,
    "content" TEXT,
    "upvotes" TEXT,
    "publishat" TEXT,

    CONSTRAINT "article_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "deposit" (
    "id" SERIAL NOT NULL,
    "user" TEXT,
    "date" TEXT,
    "cardId" TEXT,

    CONSTRAINT "deposit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "transfer" (
    "id" SERIAL NOT NULL,
    "user" TEXT,
    "amount" TEXT,
    "date" TEXT,
    "country" TEXT,
    "balance" TEXT,
    "cardId" TEXT,

    CONSTRAINT "transfer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "userId" TEXT NOT NULL,
    "name" TEXT,
    "date" TEXT,
    "balance" TEXT,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "withdraw" (
    "id" SERIAL NOT NULL,
    "user" TEXT,
    "amount" TEXT,
    "date" TEXT,
    "balance" TEXT,
    "cardId" TEXT,

    CONSTRAINT "withdraw_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_userId_key" ON "users"("userId");
