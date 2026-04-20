export function getLfConfigWriter() {
  const config: Array<string> = [];

  function line(str: string) {
    config.push(str.trim());
  }

  function setany(
    method: string,
    key: string,
    value?: string | number | boolean,
  ) {
    if (value === undefined) {
      line(`${method} ${key}`);
    } else if (typeof value === "boolean") {
      line(`${method} ${key} ${value ? "true" : "false"}`);
    } else if (typeof value === "number") {
      line(`${method} ${key} ${value}`);
    } else {
      line(`${method} ${key} ${value}`);
    }
  }

  function set(o: Record<string, string | number | boolean | undefined>) {
    for (const [k, v] of Object.entries(o)) {
      setany("set", k, v);
    }
  }

  function setlocal(
    local: string,
    key: string,
    value?: string | number | boolean,
  ) {
    setany(`setlocal ${local}`, key, value);
  }

  function lfcmd(name: string, str: string) {
    line(`cmd ${name} %{{${str}}}`);
  }

  function shcmd(name: string, str: string) {
    line(`cmd ${name} \${{${str}}}`);
  }

  function comment(str: string) {
    line(`# ${str}`);
  }

  function q(str: string) {
    return `"${str}"`;
  }

  function join(...str: string[]) {
    return str.join(";");
  }

  function mapkeys(o: Record<string, string | undefined>) {
    for (const [k, v] of Object.entries(o)) {
      if (v) {
        line(`map ${k} ${v}`);
      } else {
        line(`map ${k}`);
      }
    }
  }

  function getconfig() {
    return config.join("\n\n");
  }

  return {
    getconfig,
    set,
    setlocal,
    lfcmd,
    shcmd,
    comment,
    q,
    join,
    mapkeys,
    line,
  };
}
