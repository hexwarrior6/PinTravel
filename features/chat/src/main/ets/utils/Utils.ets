// 睡眠
export function delay(milliseconds : number) {
  return new Promise(resolve => setTimeout( resolve, milliseconds));
}