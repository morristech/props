import assign from 'lodash/assign';
import { RECEIVE_USER_PROFILE } from '../constants/users';

const userProfile = (state = {}, action = {}) => {
  switch (action.type) {
    case RECEIVE_USER_PROFILE:
      return assign({}, state,
        action.payload.profile
      );
    default:
      return state;
  }
};

export default userProfile;
