import { createBrowserRouter, RouterProvider } from 'react-router-dom';

import HomePage from 'scenes/homePage';
import LoginPage from 'scenes/loginPage';
import ProfilePage from 'scenes/profilePage';
import { useMemo } from 'react';
import { useSelector } from 'react-redux';
import { CssBaseline, ThemeProvider } from '@mui/material';
import { createTheme } from '@mui/system';
import { themeSettings } from 'theme';

function App() {
  const mode = useSelector((state) => state.mode);
  const theme = useMemo(() => createTheme(themeSettings(mode)), [mode]);

  const router = createBrowserRouter([
    {
      path: '/',
      children: [
        { index: true, element: <LoginPage /> },
        { path: 'home', element: <HomePage /> },
        { path: 'profile:userId', element: <ProfilePage /> },
      ],
    },
  ]);

  return (
    <RouterProvider router={router}>
      <ThemeProvider theme={theme}>
        <CssBaseline />
      </ThemeProvider>
    </RouterProvider>
  );
}

export default App;
