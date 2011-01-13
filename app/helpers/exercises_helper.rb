module ExercisesHelper
  def hasAllPrerequisites(courses,prerequisites)
    prerequisite_courses = prerequisites.collect{|prereq| prereq.course }
    return (courses & prerequisite_courses).length == prerequisites.length
  end
end
