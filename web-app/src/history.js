import createHistory from 'history/createBrowserHistory';

export const history = createHistory();

export const handleRedirect = route => {
    history.push(`${route}`);
};
