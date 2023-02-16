import { format } from 'path';

import User from '../models/User.js';

/* READ */
export const getUser = async (req, res) => {
  try {
    const { id } = req.params;
    const user = await User.findById(id);
    res.status(200).json(user);
  } catch (err) {
    res.status(404).json({ error: err.message });
  }
};

export const getUserFriends = async (req, res) => {
  try {
    const { id } = req.params;
    const user = await User.findById(id);

    const friends = await Promise.all(
      user.friends.map((id) => User.findById(id)),
    );

    const formattedFriends = friends.map(
      ({ _id, firstName, lastName, occupation, location, picturePath }) => {
        return {
          _id,
          firstName,
          lastName,
          occupation,
          location,
          picturePath,
        };
      },
    );
    res.status(200).json(formattedFriends);
  } catch (err) {
    res.status(404).json({ error: err.message });
  }
};

/* UPDATE */
export const addRemoveFriend = async (req, res) => {
  try {
    const { id, friendId } = req.params;
    const user = await User.findById(id);
    const friend = await User.findById(friendId);

    const isFriend = Boolean(
      user.friends.find((friend) => friend._id === friendId),
    );

    console.log('isFriend:', isFriend);

    if (isFriend) {
      user.friends = user.friends.filter((friend) => friend._id !== friendId);
      friend.friends = friend.friends.filter((friend) => friend._id !== id);
    } else {
      const userData = {
        _id: id,
        firstName: user.firstName,
        lastName: user.lastName,
        picturePath: user.picturePath,
        occupation: user.occupation,
        location: user.location,
      };
      const friendData = {
        _id: friendId,
        firstName: friend.firstName,
        lastName: friend.lastName,
        picturePath: friend.picturePath,
        occupation: friend.occupation,
        location: friend.location,
      };
      user.friends.push(friendData);
      friend.friends.push(userData);
    }

    await user.save();
    await friend.save();

    const friends = await Promise.all(
      user.friends.map((id) => User.findById(id)),
    );

    const formattedFriends = friends.map(
      ({ _id, firstName, lastName, occupation, location, picturePath }) => {
        return { _id, firstName, lastName, occupation, location, picturePath };
      },
    );
    res.status(200).json(formattedFriends);
  } catch (err) {
    console.log(err);
    res.status(404).json({ error: err.message });
  }
};
