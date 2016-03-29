import expect from 'expect';
import configureStore from './configure-store';

describe('store creator', () => {
  it('it returns store', () => {
    const store = configureStore();

    expect(store.getState()).toExist();
  });
});
