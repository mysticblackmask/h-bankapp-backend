export const validateAmount = (amount: number) => {
  if (amount <= 0) {
    return "Amount must be positive";
  }
  return null;
};

export const validateSufficientBalance = (balance: number, amount: number) => {
  if (balance < amount) {
    return "Insufficient funds";
  }
  return null;
};
