import { connect } from 'react-redux';
import { push } from 'react-router-redux';
import { get } from 'lodash';
import User from '../../components/UsersList/ThumbSmall';


const mapStateToProps = (state, ownProps) => ({
  id: get(state, `users[${ownProps.userId}].id`, 0),
  name: get(state, `users[${ownProps.userId}].name`, ''),
  avatarUrl: get(state, `users[${ownProps.userId}].avatar_url`, ''),
});

const mapDispatchToProps = dispatch => ({
  handleClick: (path) => {
    dispatch(push(path));
  },
});

export default connect(
  mapStateToProps,
  mapDispatchToProps,
)(User);
