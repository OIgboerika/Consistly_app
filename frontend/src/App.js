import React, { useState, useEffect } from "react";
import "./App.css";

function App() {
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const [currentUser, setCurrentUser] = useState(null);
  const [habits, setHabits] = useState([]);
  const [newHabit, setNewHabit] = useState("");
  const [activeTab, setActiveTab] = useState("dashboard");
  const [showLogin, setShowLogin] = useState(false);
  const [showSignup, setShowSignup] = useState(false);

  // Mock data for demonstration
  useEffect(() => {
    if (isLoggedIn) {
      setHabits([
        {
          id: 1,
          name: "Drink Water",
          streak: 7,
          completed: true,
          color: "#60A5FA",
        },
        {
          id: 2,
          name: "Read 30 min",
          streak: 3,
          completed: false,
          color: "#34D399",
        },
        {
          id: 3,
          name: "Exercise",
          streak: 12,
          completed: true,
          color: "#F87171",
        },
        {
          id: 4,
          name: "Meditate",
          streak: 5,
          completed: false,
          color: "#A78BFA",
        },
      ]);
    }
  }, [isLoggedIn]);

  const handleLogin = (e) => {
    e.preventDefault();
    setIsLoggedIn(true);
    setCurrentUser({ name: "John Doe", email: "john@example.com" });
    setShowLogin(false);
  };

  const handleSignup = (e) => {
    e.preventDefault();
    setIsLoggedIn(true);
    setCurrentUser({ name: "New User", email: "newuser@example.com" });
    setShowSignup(false);
  };

  const addHabit = (e) => {
    e.preventDefault();
    if (newHabit.trim()) {
      const habit = {
        id: Date.now(),
        name: newHabit,
        streak: 0,
        completed: false,
        color: [
          "#60A5FA",
          "#34D399",
          "#F87171",
          "#A78BFA",
          "#FBBF24",
          "#EC4899",
        ][Math.floor(Math.random() * 6)],
      };
      setHabits([...habits, habit]);
      setNewHabit("");
    }
  };

  const toggleHabit = (id) => {
    setHabits(
      habits.map((habit) =>
        habit.id === id
          ? {
              ...habit,
              completed: !habit.completed,
              streak: !habit.completed
                ? habit.streak + 1
                : Math.max(0, habit.streak - 1),
            }
          : habit
      )
    );
  };

  const deleteHabit = (id) => {
    setHabits(habits.filter((habit) => habit.id !== id));
  };

  const totalHabits = habits.length;
  const completedHabits = habits.filter((h) => h.completed).length;
  const completionRate =
    totalHabits > 0 ? Math.round((completedHabits / totalHabits) * 100) : 0;

  if (!isLoggedIn) {
    return (
      <div className="app">
        <div className="hero-section">
          <div className="hero-content">
            <h1 className="hero-title">
              <span className="gradient-text">Consistly</span>
            </h1>
            <p className="hero-subtitle">
              Build better habits, track your progress, and achieve your goals
              with our simple and beautiful habit tracker.
            </p>

            <div className="hero-stats">
              <div className="stat">
                <span className="stat-number">10K+</span>
                <span className="stat-label">Active Users</span>
              </div>
              <div className="stat">
                <span className="stat-number">500K+</span>
                <span className="stat-label">Habits Tracked</span>
              </div>
              <div className="stat">
                <span className="stat-number">95%</span>
                <span className="stat-label">Success Rate</span>
              </div>
            </div>

            <div className="auth-buttons">
              <button
                className="btn btn-primary"
                onClick={() => setShowLogin(true)}
              >
                Sign In
              </button>
              <button
                className="btn btn-secondary"
                onClick={() => setShowSignup(true)}
              >
                Get Started
              </button>
            </div>
          </div>

          <div className="hero-visual">
            <div className="mockup-dashboard">
              <div className="mockup-header">
                <div className="mockup-avatar"></div>
                <div className="mockup-title">Today's Habits</div>
              </div>
              <div className="mockup-habits">
                <div className="mockup-habit completed">
                  <div className="mockup-checkbox checked"></div>
                  <span>Drink Water</span>
                </div>
                <div className="mockup-habit">
                  <div className="mockup-checkbox"></div>
                  <span>Read 30 min</span>
                </div>
                <div className="mockup-habit completed">
                  <div className="mockup-checkbox checked"></div>
                  <span>Exercise</span>
                </div>
              </div>
            </div>
          </div>
        </div>

        {showLogin && (
          <div className="modal-overlay" onClick={() => setShowLogin(false)}>
            <div className="modal" onClick={(e) => e.stopPropagation()}>
              <h2>Welcome Back</h2>
              <form onSubmit={handleLogin}>
                <input type="email" placeholder="Email" required />
                <input type="password" placeholder="Password" required />
                <button type="submit" className="btn btn-primary">
                  Sign In
                </button>
              </form>
            </div>
          </div>
        )}

        {showSignup && (
          <div className="modal-overlay" onClick={() => setShowSignup(false)}>
            <div className="modal" onClick={(e) => e.stopPropagation()}>
              <h2>Join Consistly</h2>
              <form onSubmit={handleSignup}>
                <input type="text" placeholder="Full Name" required />
                <input type="email" placeholder="Email" required />
                <input type="password" placeholder="Password" required />
                <button type="submit" className="btn btn-primary">
                  Create Account
                </button>
              </form>
            </div>
          </div>
        )}
      </div>
    );
  }

  return (
    <div className="app">
      <nav className="navbar">
        <div className="nav-brand">
          <span className="gradient-text">Consistly</span>
        </div>
        <div className="nav-tabs">
          <button
            className={`nav-tab ${activeTab === "dashboard" ? "active" : ""}`}
            onClick={() => setActiveTab("dashboard")}
          >
            Dashboard
          </button>
          <button
            className={`nav-tab ${activeTab === "habits" ? "active" : ""}`}
            onClick={() => setActiveTab("habits")}
          >
            Habits
          </button>
          <button
            className={`nav-tab ${activeTab === "stats" ? "active" : ""}`}
            onClick={() => setActiveTab("stats")}
          >
            Statistics
          </button>
        </div>
        <div className="nav-user">
          <span>Welcome, {currentUser.name}</span>
          <button
            className="btn btn-outline"
            onClick={() => setIsLoggedIn(false)}
          >
            Sign Out
          </button>
        </div>
      </nav>

      <main className="main-content">
        {activeTab === "dashboard" && (
          <div className="dashboard">
            <div className="dashboard-header">
              <h1>Today's Progress</h1>
              <p>Keep up the great work! You're building amazing habits.</p>
            </div>

            <div className="stats-grid">
              <div className="stat-card">
                <div className="stat-icon">📊</div>
                <div className="stat-content">
                  <h3>{completionRate}%</h3>
                  <p>Completion Rate</p>
                </div>
              </div>
              <div className="stat-card">
                <div className="stat-icon">🔥</div>
                <div className="stat-content">
                  <h3>{habits.reduce((sum, h) => sum + h.streak, 0)}</h3>
                  <p>Total Streak Days</p>
                </div>
              </div>
              <div className="stat-card">
                <div className="stat-icon">✅</div>
                <div className="stat-content">
                  <h3>
                    {completedHabits}/{totalHabits}
                  </h3>
                  <p>Completed Today</p>
                </div>
              </div>
            </div>

            <div className="habits-section">
              <h2>Your Habits</h2>
              <div className="habits-grid">
                {habits.map((habit) => (
                  <div
                    key={habit.id}
                    className={`habit-card ${
                      habit.completed ? "completed" : ""
                    }`}
                  >
                    <div className="habit-header">
                      <div
                        className="habit-color"
                        style={{ backgroundColor: habit.color }}
                      ></div>
                      <h3>{habit.name}</h3>
                      <button
                        className="delete-btn"
                        onClick={() => deleteHabit(habit.id)}
                      >
                        ×
                      </button>
                    </div>
                    <div className="habit-stats">
                      <span className="streak">
                        🔥 {habit.streak} day streak
                      </span>
                    </div>
                    <button
                      className={`habit-toggle ${
                        habit.completed ? "completed" : ""
                      }`}
                      onClick={() => toggleHabit(habit.id)}
                    >
                      {habit.completed ? "✓ Completed" : "Mark Complete"}
                    </button>
                  </div>
                ))}
              </div>
            </div>
          </div>
        )}

        {activeTab === "habits" && (
          <div className="habits-page">
            <div className="page-header">
              <h1>Manage Habits</h1>
              <p>Create and organize your daily habits</p>
            </div>

            <form onSubmit={addHabit} className="add-habit-form">
              <input
                type="text"
                value={newHabit}
                onChange={(e) => setNewHabit(e.target.value)}
                placeholder="Enter a new habit..."
                className="habit-input"
              />
              <button type="submit" className="btn btn-primary">
                Add Habit
              </button>
            </form>

            <div className="habits-list">
              {habits.map((habit) => (
                <div key={habit.id} className="habit-item">
                  <div className="habit-info">
                    <div
                      className="habit-color-dot"
                      style={{ backgroundColor: habit.color }}
                    ></div>
                    <span className="habit-name">{habit.name}</span>
                    <span className="habit-streak">🔥 {habit.streak} days</span>
                  </div>
                  <div className="habit-actions">
                    <button
                      className={`toggle-btn ${
                        habit.completed ? "completed" : ""
                      }`}
                      onClick={() => toggleHabit(habit.id)}
                    >
                      {habit.completed ? "✓" : "○"}
                    </button>
                    <button
                      className="delete-btn"
                      onClick={() => deleteHabit(habit.id)}
                    >
                      Delete
                    </button>
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}

        {activeTab === "stats" && (
          <div className="stats-page">
            <div className="page-header">
              <h1>Your Statistics</h1>
              <p>Track your progress and achievements</p>
            </div>

            <div className="stats-overview">
              <div className="chart-container">
                <h3>Weekly Progress</h3>
                <div className="weekly-chart">
                  {["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"].map(
                    (day, index) => (
                      <div key={day} className="chart-day">
                        <div
                          className="chart-bar"
                          style={{ height: `${Math.random() * 100}%` }}
                        ></div>
                        <span>{day}</span>
                      </div>
                    )
                  )}
                </div>
              </div>

              <div className="achievements">
                <h3>Recent Achievements</h3>
                <div className="achievement-list">
                  <div className="achievement">
                    <span className="achievement-icon">🏆</span>
                    <div className="achievement-content">
                      <h4>7-Day Streak</h4>
                      <p>You've maintained a habit for 7 consecutive days!</p>
                    </div>
                  </div>
                  <div className="achievement">
                    <span className="achievement-icon">⭐</span>
                    <div className="achievement-content">
                      <h4>Perfect Week</h4>
                      <p>Completed all habits for 7 days in a row!</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        )}
      </main>
    </div>
  );
}

export default App;
