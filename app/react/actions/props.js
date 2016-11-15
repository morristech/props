import fetch from 'isomorphic-fetch';
import { RECEIVE_PROPS, RECEIVE_PROPS_PAGE } from '../constants/props';

export const receiveProps = props => ({
  type: RECEIVE_PROPS,
  payload: {
    props,
  },
});

export const receivePropsPage = props => ({
  type: RECEIVE_PROPS_PAGE,
  payload: {
    hasPreviousPage: props.meta.current_page > 1,
    hasNextPage: props.meta.current_page < props.meta.total_pages,
    currentPage: props.meta.current_page,
  },
});

export const fetchProps = (page = 1) => dispatch => {
  return fetch(`/api/v1/props?page=${page}`, {
    credentials: 'same-origin',
  })
  .then(req => req.json())
  .then((json) => {
    console.log(json)
    dispatch(receiveProps(json));
    dispatch(receivePropsPage(json));
  });
};
