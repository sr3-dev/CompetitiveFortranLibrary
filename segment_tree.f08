module precisions
  !set appropriately for individual problem
  integer,parameter::pi = 8, pf = 8
end module precisions

module global_variables
  use precisions
  !set appropriately for individual problem
  integer,parameter::max_n = 200000, max_q = 200000
  integer n, q, a, b
  integer,allocatable::x(:)
  !set appropriately for individual problem
  integer(pi)::inf = 40000000000
end module global_variables

module mod_segment_tree
  use precisions
  implicit none

  type::segment_tree
    integer size; 
    integer(pi)::inf
    integer(pi),allocatable::tree(:)

  contains
    procedure::init
    procedure::init_rmq
    procedure::update
    procedure::rmq
    procedure::rmq_req
    procedure::init_sum
    procedure::rsq
    procedure::rsq_req

  end type segment_tree

  contains

    subroutine init(self, n, set_inf)
      implicit none
      class(segment_tree),intent(inout)::self
      integer n
      integer(pi) set_inf
      self%inf = set_inf
      call self%init_rmq(n, set_inf)
    end subroutine init

    subroutine init_rmq(self, n, set_inf)
      implicit none
      class(segment_tree),intent(inout)::self
      integer,intent(in)::n
      integer m
      integer(pi) set_inf
      self%inf = set_inf
      m = 1
      do while (m < n)
        m = m * 2
      enddo
      allocate(self%tree(0:m*2-2))
      self%tree(0:m*2-2) = self%inf
      self%size = m
    end subroutine init_rmq

    subroutine update(self, idx, val)
      use precisions
      implicit none
      class(segment_tree),intent(inout)::self
      integer,intent(in)::idx
      integer(pi),intent(in)::val
      integer i
      i = idx + self%size - 1
      self%tree(i) = val
      do while (i > 0)
        i = (i - 1)/2
        self%tree(i) = min(self%tree(i*2+1), self%tree(i*2+2))
      enddo
    end subroutine update

    integer(pi) recursive function rmq_req(self, s, e, k, l, r) result(res)
      implicit none
      integer s, e, k, l, r
      class(segment_tree),intent(inout)::self
      if (r <= s .or. e <= l) then
          res = self%inf
        else if (s <= l .and. r <= e) then
        res = self%tree(k)
      else 
        res = min(rmq_req(self, s, e, k*2+1, l, (l+r)/2), rmq_req(self, s, e, k*2+2, (l+r)/2, r))
      endif
    end function rmq_req

    integer(pi) recursive function rmq(self, s, e)
      implicit none
      integer s, e
      class(segment_tree),intent(inout)::self
      rmq = rmq_req(self, s, e, 0, 0, self%size)
    end function rmq 

    subroutine init_sum(self, n)
      implicit none
      class(segment_tree),intent(inout)::self
      integer,intent(in)::n
      integer m
      m = 1
      do while (m < n)
        m = m * 2
      enddo
      allocate(self%tree(0:m*2-2))
      self%tree = 0
      self%size = m
    end subroutine init_sum

    integer(pi) recursive function rsq_req(self, s, e, k, l, r) result(res)
      implicit none
      integer s, e, k, l, r
      class(segment_tree),intent(inout)::self
      if (r <= s .or. e <= l) then
          res = 0
        else if (s <= l .and. r <= e) then
        res = self%tree(k)
      else 
        res = min(rsq_req(self, s, e, k*2+1, l, (l+r)/2), rsq_req(self, s, e, k*2+2, (l+r)/2, r))
      endif
    end function rsq_req

    integer(pi) recursive function rsq(self, s, e)
      implicit none
      integer s, e
      class(segment_tree),intent(inout)::self
      rsq = rsq_req(self, s, e, 0, 0, self%size)
    end function rsq 

end module mod_segment_tree

program segment_tree
  use precisions
  use global_variables
  use mod_segment_tree
  implicit none
  integer n, i, a

  type(segment_tree) st
  call st%init_rmq(n, inf)
  call st%update(i, a)
  print '(i0)', st%rmq(i,i+1)
end program segment_tree
