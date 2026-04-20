import { config } from "./config";
import path from "path";

const addr = path.resolve(process.cwd(), "..", "lfrc");
const file = Bun.file(addr);
const exists = await file.exists();

if (exists) {
  const content = await file.text();

  if (content.length !== 0) {
    console.error("lfrc file is not empty");
    process.exit(1);
  }
}

const bytes = await Bun.write(addr, config);

console.log(`Wrote ${bytes} bytes to ${addr}`);
process.exit(0);
