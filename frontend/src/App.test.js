import { render, screen } from "@testing-library/react";
import App from "./App";

test("renders app title", () => {
  render(<App />);
  const titleElement = screen.getByText(/Consistly/i);
  expect(titleElement).toBeInTheDocument();
});

test("renders habit tracker", () => {
  render(<App />);
  const habitElement = screen.getByText(/Habit Tracker/i);
  expect(habitElement).toBeInTheDocument();
});
