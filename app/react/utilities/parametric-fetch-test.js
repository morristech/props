import ParametricFetch from '../utilities/parametric-fetch';
import expect from 'expect';

describe('parameterizeUrl', () => {
  const api = new ParametricFetch({ baseURI: '/api/v1' });

  it('it returns parametrized url with encoded params', () => {
    expect(api.parameterizeUrl('/props', { propser_id: 1, page: 1, per_page: 1 }))
    .toEqual('/props?propser_id=1&page=1&per_page=1');
  });

  it('it returns url without params', () => {
    expect(api.parameterizeUrl('/users/1')).toEqual('/users/1');
  });
});
