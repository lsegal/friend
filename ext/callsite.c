#include "callsite.h"

VALUE
callsite_caller_class(VALUE self)
{
#ifdef RUBY19
	rb_control_frame_t *cfp = ruby_current_thread->cfp;
	/* pop 2 stack frames */
	cfp = RUBY_VM_PREVIOUS_CONTROL_FRAME(cfp);
	cfp = RUBY_VM_PREVIOUS_CONTROL_FRAME(cfp);
	
	/* pop any block stack frames */
	while (!cfp->iseq) cfp = RUBY_VM_PREVIOUS_CONTROL_FRAME(cfp);
	
	if (cfp->iseq != 0 && cfp->pc != 0) {
		return cfp->iseq->klass;
	}
	return Qnil;
#else /* RUBY18 */
	struct FRAME *frame = ruby_frame->prev->prev;
	if (frame->flags == 1) frame = frame->prev;
	return frame->last_class;
#endif /* RUBY19 */
}

void
Init_callsite()
{
	rb_define_method(rb_mKernel, "caller_class", callsite_caller_class, 0);
}