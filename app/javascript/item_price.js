function updatePriceCalculation() {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const taxValue = Math.floor(inputValue * 0.1);  // 税金を計算
    addTaxDom.innerHTML = taxValue;  // 税金を表示
    const profitDom = document.getElementById("profit");
    profitDom.innerHTML = Math.floor(inputValue - taxValue);  // 利益を表示
  });
}

window.addEventListener('turbo:load', updatePriceCalculation);
