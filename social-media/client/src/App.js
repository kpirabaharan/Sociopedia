import { createBrowserRouter, RouterProvider } from 'react-router-dom';

import HomePage from 'scenes/homePage';
import LoginPage from 'scenes/loginPage';
import ProfilePage from 'scenes/profilePage';

function App() {
  const router = createBrowserRouter([
    {
      path: '/',
      children: [
        {
          index: true,
          element: <LoginPage />,
          children: [
            { path: 'home', element: <HomePage /> },
            { path: 'profile:userId', element: <ProfilePage /> },
          ],
        },
      ],
    },
  ]);

  return <RouterProvider router={router} />;
}

export default App;
