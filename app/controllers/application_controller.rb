class ApplicationController < Sinatra::Base

  # set :default_content_type, 'application/json'

  get '/games' do
    games = Game.all.order(:title).limit(10)
    games.to_json
  end

  # Dynamic way
  get '/games/:id' do
    game = Game.find(params[:id])
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      }}
    })
  end 

end


#  What our React code would look like:

# function GameDetail({ gameId }) {
#   const [game, setGame] = useState(null);

#   useEffect(() => {
#     fetch(`http://localhost:9292/games/${gameId}`)
#       .then((r) => r.json())
#       .then((game) => setGame(game));
#   }, [gameId]);

#   if (!game) return <h2>Loading game data...</h2>;

#   return (
#     <div>
#       <h2>{game.title}</h2>
#       <p>Genre: {game.genre}</p>
#       <h4>Reviews</h4>
#       {game.reviews.map((review) => (
#         <div>
#           <h5>{review.user.name}</h5>
#           <p>Score: {review.score}</p>
#           <p>Comment: {review.comment}</p>
#         </div>
#       ))}
#     </div>
#   );
# } 
