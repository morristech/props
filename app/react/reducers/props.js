import { RECEIVE_PROPS } from '../constants/props';

const props = (state = [], action = {}) => {
  switch (action.type) {
    case RECEIVE_PROPS: {
      const receivedProps = action.payload.props;
      const normalizedProps = [];
      receivedProps.forEach((prop) => {
        const usersIds = prop.users.map(u => u.id);
        const propser = prop.propser.id;
        normalizedProps.push(
          Object.assign(prop, { propser, users: usersIds })
        );
      });
      return normalizedProps;
    }
    default:
      return state;
  }
};

export default props;
