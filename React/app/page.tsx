"use client";
import { destroyCookie, setCookie } from "nookies";
import styles from "./page.module.css";

export default function Home() {
  return (
    <main className={styles.main}>
      <div></div>

      <div className={styles.buttons}>
        <button onClick={() => createCookie()}>Create Cookie</button>
        <button onClick={() => deleteCookie()}>Destroy Cookie</button>
      </div>

      <div></div>
    </main>
  );
}

function createCookie() {
  setCookie(null, "myCookie", Math.random().toString(), {
    maxAge: 30 * 24 * 60 * 60,
  });
}

function deleteCookie() {
  destroyCookie(null, "myCookie");
}
