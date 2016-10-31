import { connect } from 'react-redux';
import { push } from 'react-router-redux';
import Navbar from '../../components/navbar/navbar';


const mapStateToProps = state => ({
});

const mapDispatchToProps = dispatch => ({
  handleLinkClicked: (path) => {
    dispatch(push(path));
  },
});

export default connect(
  mapStateToProps,
  mapDispatchToProps,
)(Navbar);
