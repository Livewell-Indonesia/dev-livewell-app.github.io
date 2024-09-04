class Formula {
  static double proteinPercentage(num protein, num totalCalories) {
    if (totalCalories == 0) {
      return 0.0;
    }
    return protein / ((0.2 * totalCalories) / 4);
  }

  static double carbohydratePercentage(num carbohydrate, num totalCalories) {
    if (totalCalories == 0) {
      return 0.0;
    }
    return carbohydrate / ((0.5 * totalCalories) / 4);
  }

  static double fatPercentage(num fat, num totalCalories) {
    if (totalCalories == 0) {
      return 0.0;
    }
    return fat / ((0.3 * totalCalories) / 9);
  }

  static double averageMacroPercentage(double protein, double carbs, double fat) {
    return (protein + carbs + fat) / 3;
  }

  static double averageMicroPercentage(double vit, double majorMineral, double minorMineral) {
    return (vit + majorMineral + minorMineral) / 3;
  }

  static double targetProteinConsumed(num target) {
    return target * 0.2 / 4;
  }

  static double targetCarbohydrateConsumed(num target) {
    return target * 0.5 / 4;
  }

  static double targetFatConsumed(num target) {
    return target * 0.3 / 9;
  }

  static double averageEssentialVitamins(
      double vitA, double vitC, double vitD, double vitE, double vitK, double vitb1, double vitb2, double vitb3, double vitb5, double vitb6, double vitb7, double vitb9, double vitb12) {
    return (vitA + vitC + vitD + vitE + vitK + vitb1 + vitb2 + vitb3 + vitb5 + vitb6 + vitb7 + vitb9 + vitb12) / 13;
  }

  static double averageMajorMineral(double calcium, double magnesium, double phosphorus, double chloride, double potassium, double sodium) {
    return (calcium + magnesium + phosphorus + chloride + potassium + sodium) / 6;
  }

  static double averageMinorMineral(double iron, double iodine, double zinc, double selenium, double fluoride, double chromium, double molybdenum) {
    return (iron + iodine + zinc + selenium + fluoride + chromium + molybdenum) / 7;
  }

  static double vitAPercentage(double vitA) {
    return vitA / 800;
  }

  static double vitCPercentage(double vitC) {
    return vitC / 110;
  }

  static double vitDPercentage(double vitD) {
    return vitD / 18;
  }

  static double vitEPercentage(double vitE) {
    return vitE / 15;
  }

  static double vitKPercentage(double vitK) {
    return vitK / 110;
  }

  static double vitB1Percentage(double vitB1) {
    return vitB1 / 1.2;
  }

  static double vitB2Percentage(double vitB2) {
    return vitB2 / 110;
  }

  static double vitB3Percentage(double vitB3) {
    return vitB3 / 15;
  }

  static double vitB5Percentage(double vitB5) {
    return vitB5 / 5;
  }

  static double vitB6Percentage(double vitB6) {
    return vitB6 / 1.5;
  }

  static double vitB7Percentage(double vitB7) {
    return vitB7 / 30;
  }

  static double vitB9Percentage(double vitB9) {
    return vitB9 / 400;
  }

  static double vitB12Percentage(double vitB12) {
    return vitB12 / 2.4;
  }

  static double calciumPercentage(double calcium) {
    return calcium / 1000;
  }

  static double magnesiumPercentage(double magnesium) {
    return magnesium / 350;
  }

  static double phosphorusPercentage(double phosphorus) {
    return phosphorus / 700;
  }

  static double chloridePercentage(double chloride) {
    return chloride / 3;
  }

  static double potassiumPercentage(double potassium) {
    return potassium / 4700;
  }

  static double sodiumPercentage(double sodium) {
    return sodium / 1500;
  }

  static double ironPercentage(double iron) {
    return iron / 8.7;
  }

  static double iodinePercentage(double iodine) {
    return iodine / 140;
  }

  static double zincPercentage(double zinc) {
    return zinc / 9;
  }

  static double seleniumPercentage(double selenium) {
    return selenium / 55;
  }

  static double fluoridePercentage(double fluoride) {
    return fluoride / 3.5;
  }

  static double chromiumPercentage(double chromium) {
    return chromium / 25;
  }

  static double molybdenumPercentage(double molybdenum) {
    return molybdenum / 90;
  }
}
