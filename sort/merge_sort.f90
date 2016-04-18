! 昇順のソート
module sort
  implicit none
  private
  integer :: i,j,k
  logical :: reverse_internal,hikaku
  public :: merge_sort
  interface merge_sort
     module procedure merge_sort_int, merge_sort_real
  end interface merge_sort

  contains
    recursive subroutine merge_sort_int(a,reverse)
      implicit none
      integer,dimension(:),intent(inout) :: a
      logical,intent(in),optional :: reverse
      integer :: mid,left,right
      integer :: tmp(lbound(a,1):ubound(a,1))

      left  = lbound(a,1)
      right = ubound(a,1)
      
      if(left >= right) return
      if(present(reverse)) then
         reverse_internal = reverse
      else
         reverse_internal = .False.
      end if

      mid  = (left+right)/2
      call merge_sort_int(a(left:mid),reverse_internal)
      call merge_sort_int(a(mid+1:right),reverse_internal)

      tmp = a
      i = left
      j = mid+1

      do k=left,right
         if(i>=mid+1) then
            a(k:right) = tmp(j:right)
            exit
         else if(j>=right+1) then
            a(k:right) = tmp(i:mid)
            exit
         else 
            if(reverse_internal) then
               hikaku = tmp(i) >= tmp(j) ! 降順
            else
               hikaku = tmp(i) <= tmp(j) ! 昇順
            end if

            if(hikaku) then
               a(k) = tmp(i)
               i = i+1
            else
               a(k) = tmp(j)
               j = j+1
            end if
         end if
      end do
      return
    end subroutine merge_sort_int
    recursive subroutine merge_sort_real(a,reverse)
      implicit none
      real(8),dimension(:),intent(inout) :: a
      logical,intent(in),optional :: reverse
      integer :: mid,left,right
      real(8) :: tmp(lbound(a,1):ubound(a,1))

      left  = lbound(a,1)
      right = ubound(a,1)

      if(left >= right) return
      if(present(reverse)) then
         reverse_internal = reverse
      else
         reverse_internal = .False.
      end if

      mid  = (left+right)/2
      call merge_sort_real(a(left:mid),reverse_internal)
      call merge_sort_real(a(mid+1:right),reverse_internal)

      tmp = a
      i = left
      j = mid+1

      do k=left,right
         if(i>=mid+1) then
            a(k) = tmp(j)
            j = j+1
         else if(j>=right+1) then
            a(k) = tmp(i)
            i = i+1
         else
            if(reverse_internal) then
               hikaku = tmp(i) >= tmp(j) ! 降順
            else
               hikaku = tmp(i) <= tmp(j) ! 昇順
            end if

            if(hikaku) then
               a(k) = tmp(i)
               i = i+1
            else
               a(k) = tmp(j)
               j = j+1
            end if
         end if
      end do
      return
    end subroutine merge_sort_real
end module sort
