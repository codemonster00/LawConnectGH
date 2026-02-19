"use client";

import React, { createContext, useContext, useState, useEffect, useCallback } from "react";

interface AuthUser {
  userId: string;
  role: string;
  fullName: string;
}

interface AuthContextType {
  user: AuthUser | null;
  token: string | null;
  login: (token: string, userId: string, role: string) => void;
  logout: () => void;
  isLoading: boolean;
}

const AuthContext = createContext<AuthContextType>({
  user: null,
  token: null,
  login: () => {},
  logout: () => {},
  isLoading: true,
});

export function useAuth() {
  return useContext(AuthContext);
}

function parseJwt(token: string): Record<string, string> {
  try {
    const base64 = token.split(".")[1].replace(/-/g, "+").replace(/_/g, "/");
    return JSON.parse(atob(base64));
  } catch {
    return {};
  }
}

export default function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<AuthUser | null>(null);
  const [token, setToken] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    const saved = localStorage.getItem("token");
    if (saved) {
      const claims = parseJwt(saved);
      const name =
        claims["http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"] || "";
      const role =
        claims["http://schemas.microsoft.com/ws/2008/06/identity/claims/role"] || "";
      const id =
        claims["http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier"] || "";
      setToken(saved);
      setUser({ userId: id, role, fullName: name });
    }
    setIsLoading(false);
  }, []);

  const login = useCallback((tok: string, userId: string, role: string) => {
    localStorage.setItem("token", tok);
    const claims = parseJwt(tok);
    const name =
      claims["http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"] || "";
    setToken(tok);
    setUser({ userId, role, fullName: name });
  }, []);

  const logout = useCallback(() => {
    localStorage.removeItem("token");
    setToken(null);
    setUser(null);
  }, []);

  return (
    <AuthContext.Provider value={{ user, token, login, logout, isLoading }}>
      {children}
    </AuthContext.Provider>
  );
}
