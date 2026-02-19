import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./components/**/*.{js,ts,jsx,tsx,mdx}",
    "./app/**/*.{js,ts,jsx,tsx,mdx}",
    "./lib/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        primary: {
          DEFAULT: "#1e3a5f",
          light: "#2a4f7f",
          dark: "#152a45",
        },
        accent: {
          DEFAULT: "#d4a843",
          light: "#e0be6a",
          dark: "#b8912e",
        },
        success: "#16a34a",
        slate: {
          750: "#293548",
        },
      },
    },
  },
  plugins: [],
};
export default config;
