require File.expand_path(File.dirname(__FILE__) + '/neo')

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used to calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points
#
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.

#def score(dice)
#  score = 0
#  x = 0
#  while x <= 6
#    triples = dice.select { |item| (item) == x }
#    if triples.length > 2 && triples[0] == 1
#      score += 1000
#    elsif triples.length > 2
#      score += triples[0] * 100
#    elsif triples.length == 4 && triples[0] == 1
#      score += 100
#    elsif triples.length == 5 && triples[0] == 1
#      score += 200
#    elsif triples.length == 4 && triples[0] == 5
#      score += 50
#    elsif triples.length == 5 && triples[0] == 5
#      score += 100
#    end
#    x += 1
#  end
#
#  if score == 0 || triples[0] == 2 || triples[0] == 3 || score == 200 || score == 500
#    dice.each do |die|
#      puts score 
#      score += 50 if die == 5
#      score += 100 if die == 1
#    end
#  end
#
#  score
#end

def score(dice)
  @score = 0
  dice.sort!  
  if dice[1] == dice[2] && dice[1] == dice[0] && dice[0] != nil
    if dice[0] == 1
      @score += 1000
    elsif dice[0] == 5
      @score += 500
    else
      @score += dice[0] * 100
    end
    score_die(dice[3]) if dice.length > 3
    score_die(dice[4]) if dice.length > 4
  else
    dice.each { |dice| score_die(dice) }
  end
  @score
end

def score_die(die)
  @score += 100 if die == 1 
  @score += 50 if die == 5
end

class AboutScoringProject < Neo::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1,5,5,1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2,3,4,6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score([1,1,1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, score([2,2,2])
    assert_equal 300, score([3,3,3])
    assert_equal 400, score([4,4,4])
    assert_equal 500, score([5,5,5])
    assert_equal 600, score([6,6,6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, score([2,5,2,2,3])
    assert_equal 550, score([5,5,5,5])
  end

end
