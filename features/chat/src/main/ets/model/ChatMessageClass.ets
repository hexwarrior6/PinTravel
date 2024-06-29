@Observed
export class ChatMessageClass {
  id: number
  role: string = '';
  content?: string = '';

  constructor(id: number, role: string, text?: string) {
    this.id = id;
    this.role = role;
    this.content = text;
  }
}