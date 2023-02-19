import { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Box, Typography, useTheme } from '@mui/material';

import { setFriends } from 'state';
import WidgetWrapper from 'components/WidgetWrapper';
import Friend from 'components/Friend';

const FriendListWidget = ({ userId, isProfile = false }) => {
  const dispatch = useDispatch();
  const token = useSelector((state) => state.token);
  const friends = useSelector((state) => state.user.friends);
  const { palette } = useTheme();

  const getFriends = async () => {
    const response = await fetch(
      `http://localhost:8080/users/${userId}/friends`,
      {
        method: 'GET',
        headers: { Authorization: `Bearer ${token}` },
      },
    );

    const data = await response.json();
    dispatch(setFriends({ friends: data }));
  };

  useEffect(() => {
    getFriends();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <WidgetWrapper>
      <Typography
        color={palette.neutral.dark}
        variant='h5'
        fontWeight='500'
        sx={{ mb: '1.5rem' }}
      >
        Friend List
      </Typography>
      <Box display='flex' flexDirection='column' gap='1.5rem'>
        {friends.map((friend) => (
          <Friend
            key={friend._id}
            friendId={friend._id}
            name={`${friend.firstName} ${friend.lastName}`}
            subtitle={friend.occupation}
            userPicturePath={friend.picturePath}
            isProfile={isProfile}
          />
        ))}
      </Box>
    </WidgetWrapper>
  );
};

export default FriendListWidget;
