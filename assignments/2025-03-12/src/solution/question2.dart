/*
// 주어진 숫자가 소수인지 확인하는 함수를 작성하세요.
bool isPrime(int number) {
  // for문과 if문을 사용하여 구현하세요
}
*/

void main() {
  print(isPrime(7)); // true가 출력되어야 합니다
  print(isPrime(12)); // false가 출력되어야 합니다
  print(isPrime(23)); // true가 출력되어야 합니다
}

bool isPrime(int number) {
  int count = 1;
  if (number == 0 || number == 1) {
    return false;
  }
  for (int i = 2; i <= number; i++) {
    if (number % i == 0) {
      count++;
    }
  }
  return count == 2 ? true : false;
}
