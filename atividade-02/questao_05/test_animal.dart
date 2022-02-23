import 'animais.dart';
import 'bovine.dart';
import 'fish.dart';

void main() {
  Bovine cow = Bovine.cow();
  cow.specie = "Holstein-Frísia";
  cow.name = "Fifi";

  Bovine goat = Bovine.goat();
  goat.specie = "Hejazi";
  goat.name = "Bebeleca";

  Fish clownFish = Fish.clownFish();
  clownFish.specie = "Peixe Palhaço";
  clownFish.name = "Nemo";

  Fish pufferFish = Fish.pufferFish();
  pufferFish.specie = "Baiacu";
  pufferFish.name = "Balloon";

  print("A vaquinha ${cow.name} é da espécie ${cow.specie} e sua produção de leite por dia é de ${cow.milkProduction}L.");
  print("A cabrinha ${goat.name} é da espécie ${goat.specie} e sua produção de leite por dia é de ${goat.milkProduction}L.");

  print("A peixinho ${clownFish.name} é da espécie ${clownFish.specie} e pode atingir até ${clownFish.depth}m de profundidade.");
  print("A peixinho ${pufferFish.name} é da espécie ${pufferFish.specie} e pode atingir até ${pufferFish.depth}m de profundidade.");

  Animal randomAnimal = Bovine();

  // Letra A

  if (randomAnimal is Bovine) {
    randomAnimal.milkProduction = 10;
  }

  // Letra B

  Fish fish = Animal();
}