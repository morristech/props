import { connect } from 'react-redux';
import { push } from 'react-router-redux';
import User from '../../components/UsersList/ThumbSmall';


const mapStateToProps = (state, ownProps) => ({
  userObject: state.users[ownProps.userId],
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
