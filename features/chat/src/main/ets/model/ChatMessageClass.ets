@Observed
export class ChatMessageClass {
  isme: Boolean = true;
  text?: string = '';
  imageSrc?: string = '';

  constructor(isme: Boolean, text?: string, imageSrc?: string) {
    this.isme = isme;
    this.text = text;
    this.imageSrc = imageSrc;
  }
}