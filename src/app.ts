import express from "express";
import cors from "cors";
import { json } from "body-parser";
import BankRoute from "./routes/bank.routes";
import DashRoute from "./routes/dash.routes";

const app = express();

const corsOptions = {
  origin: process.env.FRONTEND,
  methods: process.env.FRONTENDMETHODS,
  allowedHeaders: ["Content-Type", "Authorization"],
};

app.use(cors(corsOptions));

app.use(json());

// Routes
app.use("/bank", BankRoute);
app.use("/dash", DashRoute);

export { app };
