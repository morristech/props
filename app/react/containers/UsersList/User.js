import { connect } from 'react-redux';
import User from '../../components/UsersList/User';


const mapStateToProps = (state, ownProps) => ({
  userObject: state.users[ownProps.userId],
});

const mapDispatchToProps = (dispatch) => ({
});

export default connect(
  mapStateToProps,
  mapDispatchToProps,
)(User);
