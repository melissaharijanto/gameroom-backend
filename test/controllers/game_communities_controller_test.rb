require "test_helper"

class GameCommunitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game_community = game_communities(:one)
  end

  test "should get index" do
    get game_communities_url, as: :json
    assert_response :success
  end

  test "should create game_community" do
    assert_difference("GameCommunity.count") do
      post game_communities_url, params: { game_community: { followers: @game_community.followers, image_url: @game_community.image_url, title: @game_community.title } }, as: :json
    end

    assert_response :created
  end

  test "should show game_community" do
    get game_community_url(@game_community), as: :json
    assert_response :success
  end

  test "should update game_community" do
    patch game_community_url(@game_community), params: { game_community: { followers: @game_community.followers, image_url: @game_community.image_url, title: @game_community.title } }, as: :json
    assert_response :success
  end

  test "should destroy game_community" do
    assert_difference("GameCommunity.count", -1) do
      delete game_community_url(@game_community), as: :json
    end

    assert_response :no_content
  end
end
