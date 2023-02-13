import { useMemo } from 'react';
import { useSelector } from 'react-redux';
import {
  createBrowserRouter,
  RouterProvider,
  Navigate,
} from 'react-router-dom';
import { CssBaseline, ThemeProvider } from '@mui/material';
import { createTheme } from '@mui/material/styles';

import { themeSettings } from './theme';
import HomePage from 'scenes/homePage';
import LoginPage from 'scenes/loginPage';
import ProfilePage from 'scenes/profilePage';

function App() {
  const mode = useSelector((state) => state.mode);
  const theme = useMemo(() => createTheme(themeSettings(mode)), [mode]);
  const isAuth = Boolean(useSelector((state) => state.token));

  const router = createBrowserRouter([
    {
      path: '/',
      children: [
        {
          index: true,
          element: !isAuth ? <LoginPage /> : <Navigate to={'/home'} />,
        },
        {
          path: 'home',
          element: isAuth ? <HomePage /> : <Navigate to={'/'} />,
        },
        {
          path: 'profile:userId',
          element: isAuth ? <ProfilePage /> : <Navigate to={'/'} />,
        },
      ],
    },
  ]);

  return (
    <div className='app'>
      <ThemeProvider theme={theme}>
        <CssBaseline />
        <RouterProvider router={router} />
      </ThemeProvider>
    </div>
  );
}

export default App;
