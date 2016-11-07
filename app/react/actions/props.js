import fetch from 'isomorphic-fetch';

export const receiveAllProps = props => ({
  type: 'RECEIVE_ALL_PROPS',
  payload: {
    props,
  },
});

export const fetchProps = () => dispatch => {
  return fetch('/api/v1/props?page=1', {
    credentials: 'same-origin',
  })
  .then(req => req.json())
  .then(json => dispatch(receiveAllProps(json)));
};
