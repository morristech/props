import { connect } from 'react-redux';
import PropsList from '../../components/PropsList';


const mapStateToProps = state => ({
  propsList: state.props,
});

const mapDispatchToProps = dispatch => ({
});

export default connect(
  mapStateToProps,
  mapDispatchToProps,
)(PropsList);
