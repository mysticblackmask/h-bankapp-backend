import { Request, Response } from "express";
import express from "express";
import {
  deposit,
  withdraw,
  transfer,
  totalAmount,
  history,
} from "../controllers/bank.controllers";

const router = express.Router();

router.post("/:id/deposit", async (req: Request, res: Response) => {
  await deposit(req, res);
});

router.post("/:id/withdraw", async (req: Request, res: Response) => {
  await withdraw(req, res);
});

router.post("/:id/transfer", async (req: Request, res: Response) => {
  await transfer(req, res);
});

router.get("/:id/total", async (req: Request, res: Response) => {
  await totalAmount(req, res);
});

router.post("/:id/history", async (req: Request, res: Response) => {
  await history(req, res);
});

export default router;
