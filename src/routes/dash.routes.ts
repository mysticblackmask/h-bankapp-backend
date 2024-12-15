import { Request, Response } from "express";
import express from "express";
import { dashes } from "../controllers/dash.controllers";

const router = express.Router();

router.get("/:id", async (req: Request, res: Response) => {
  await dashes(req, res);
});

export default router;
