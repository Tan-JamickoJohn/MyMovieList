import './App.css';
import { useState, useEffect } from 'react';
import SearchIcon from '@material-ui/icons/Search';
import AccountCircleIcon from '@material-ui/icons/AccountCircle';
import axios from 'axios';

import Movie from './components/Movie';



const App = () => {

  const [movies, setMovies] = useState([]);
  const [query, setQuery] = useState('');

  useEffect(() => {
    axios.get("https://api.themoviedb.org/3/movie/popular?api_key=e9085c32cd25783e01c2ae6ef814c537&language=en-US&page=1")
      .then((res) => setMovies(res.data.results));
  },[])

  const search = () => {
    axios.get(`https://api.themoviedb.org/3/search/movie?api_key=e9085c32cd25783e01c2ae6ef814c537&language=en-US&query=${query}&page=1&include_adult=false`)
    .then((res) => setMovies(res.data.results));
  }

  return(
    <div className="App">
      <div className="App-header">
        <SearchIcon fontSize="large"/>
        <AccountCircleIcon fontSize="large"/>
      </div>
      <div className="Title">
          <h1>MyMovieList</h1>
          <p>Find movies and keep track and of what you’ve watched and plan to watch.</p>
      </div>
        <form className="Search">
          <input type='text' 
          value={query} 
          onChange={((e) => setQuery(e.target.value))}/>
          <SearchIcon 
          onClick={search}
          style={{position:'relative', right: 35, top: 7.5}}/>
      </form>
      <div className="Movies-container">
      {movies.map(movie => (
        <Movie {...movie} />
      ))}
      </div>
    </div>
  )
}

export default App;
