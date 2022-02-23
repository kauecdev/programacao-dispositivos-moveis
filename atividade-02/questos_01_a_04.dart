void main() {
  // Questão 01

  print("Questão 01");

  List<double> numbersToSum = [2, 8, 12];
  double sumResult = sumNumbersInList(numbersToSum);

  print("Sum result: $sumResult");

  // Questão 02

  print("Questão 02");

  List<double> numbersToMultiply = [3, 5, 9];
  double multiplicationResult = multiplyNumbersInList(numbersToMultiply);

  print("Multiplication result: $multiplicationResult");

  // Questão 03

  print("Questão 03");

  List<double> numbersToExecuteSumOperation = [4, 3, 5];
  double sumOperationResult = executeOperationInNumbersList(
      sumNumbersInList, numbersToExecuteSumOperation);

  print("Sum operation result: $sumOperationResult");

  List<double> numbersToExecuteMultiplicationOperation = [7, 9, 11];
  double multiplicationOperationResult = executeOperationInNumbersList(
      multiplyNumbersInList, numbersToExecuteMultiplicationOperation);

  print("Multiplication operation result: $multiplicationOperationResult");

  // Questão 04

  print("Questão 04");

  double exponentiationResult = exponentiation(2, 3);

  print("Exponentiation result: $exponentiationResult");

  double exponentiationArrowFunction(double base, double exponent) =>
      exponent == 1
          ? base
          : base * exponentiationArrowFunction(base, exponent - 1);

  double exponentiationArrowFunctionResult = exponentiationArrowFunction(2, 3);

  print(
      "Exponentiation Arrow Function result: $exponentiationArrowFunctionResult");
}

sumNumbersInList(List<double> numbersList) {
  return numbersList.reduce((a, b) => a + b);
}

multiplyNumbersInList(List<double> numbersList) {
  return numbersList.reduce((a, b) => a * b);
}

executeOperationInNumbersList(
    Function operationToExecute, List<double> numbersList) {
  return operationToExecute(numbersList);
}

exponentiation(double base, double exponent) {
  double result = 1;

  for (int i = 0; i < exponent; i++) {
    result *= base;
  }

  return result;
}
