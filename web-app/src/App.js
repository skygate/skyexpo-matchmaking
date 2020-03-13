import React from 'react';
import { Provider } from 'react-redux';

import 'react-circular-progressbar/dist/styles.css';

import { MainRouter } from './routing/MainRouter';
import { store } from './configureStore';
import { appInit } from './actions/init';

store.dispatch(appInit());

export const App = () => (
    <Provider store={store}>
        <div className="App">
            <MainRouter />
        </div>
    </Provider>
);
