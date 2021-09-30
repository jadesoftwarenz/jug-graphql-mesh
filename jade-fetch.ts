import fetch from "node-fetch";

/**
 * Patches the fetch function to support fetching from a jade ISAPI
 * interface
 */
export default function patchedFetch(url: string, args?: RequestInit) {
  return fetch(`${url}?FinRestApp`, args);
}
